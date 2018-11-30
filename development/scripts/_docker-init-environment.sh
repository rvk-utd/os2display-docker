#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
bold=$(tput bold)
normal=$(tput sgr0)

cd /var/www/admin
composer install
chown -R www-data:www-data app/cache app/logs
sudo -u www-data app/console doctrine:migrations:migrate --no-interaction
sudo -u www-data app/console os2display:core:templates:load
sudo -u www-data app/console doctrine:query:sql "UPDATE ik_screen_templates SET enabled=1;"
sudo -u www-data app/console doctrine:query:sql "UPDATE ik_slide_templates SET enabled=1;"
app/console fos:user:create admin admin@example.com admin --super-admin || true

# TODO - only do this if the indexes has not already been enabled.
# Initialize the search index
JSON_RESULT=$(curl -s "http://search:3010/authenticate" -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data @<(cat <<EOF
{
   "apikey": "795359dd2c81fa41af67faa2f9adbd32"
  }
EOF
) 2>/dev/null)

TOKEN=$(echo $JSON_RESULT|php -r 'echo json_decode(fgets(STDIN))->token;')

curl -s "http://search:3010/api/e7df7cd2ca07f4f1ab415d457a6e1c13/activate" -H "Authorization: Bearer $TOKEN" 2>/dev/null


# Activate shared indexes
JSON_RESULT=$(curl -s "http://search:3010/authenticate" -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data @<(cat <<EOF
{
   "apikey": "88cfd4b277f3f8b6c7c15d7a84784067"
  }
EOF
) 2>/dev/null)

TOKEN=$(echo $JSON_RESULT|php -r 'echo json_decode(fgets(STDIN))->token;')

curl "http://search:3010/api/bibshare/activate" -H "Authorization: Bearer $TOKEN"
curl "http://search:3010/api/itkdevshare/activate" -H "Authorization: Bearer $TOKEN"

JSON_RESULT=$(curl -s "http://search:3010/authenticate" -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data @<(cat <<EOF
{
   "apikey": "795359dd2c81fa41af67faa2f9adbd32"
  }
EOF
) 2>/dev/null)

TOKEN=$(echo $JSON_RESULT|php -r 'echo json_decode(fgets(STDIN))->token;')

function initialise_type {
curl -s "http://search:3010/api" -H "Authorization: Bearer $TOKEN" -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data @<(cat <<EOF
{
      "index":"e7df7cd2ca07f4f1ab415d457a6e1c13",
      "type":"$1",
      "id":1,
      "data": {
        "name": "test",
        "user": 1,
        "created_at": 0
      }
}
EOF
)

curl -s "http://search:3010/api" -H "Authorization: Bearer $TOKEN" -H "Accept: application/json" -H "Content-Type:application/json" -X DELETE --data @<(cat <<EOF
{
      "index":"e7df7cd2ca07f4f1ab415d457a6e1c13",
      "type":"$1",
      "id":1
}
EOF
)
}

arr="Os2Display\\\\CoreBundle\\\\Entity\\\\Slide
Os2Display\\\\CoreBundle\\\\Entity\\\\Channel
Os2Display\\\\CoreBundle\\\\Entity\\\\Screen
Os2Display\\\\MediaBundle\\\\Entity\\\\Media"
# TODO only do this if the types have not already been initialized.
for TYPE in $arr
do
(
    initialise_type $TYPE
)
done
