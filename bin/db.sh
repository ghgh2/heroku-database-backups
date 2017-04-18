#!/bin/bash

BACKUP_FILE_NAME="$(date +"%Y-%m-%d-%H-%M")-$1-$2.dump"

/app/vendor/heroku-toolbelt/bin/heroku pg:backups capture $2 --app $1
curl -o $BACKUP_FILE_NAME `/app/vendor/heroku-toolbelt/bin/heroku pg:backups:url --app $1`
gzip $BACKUP_FILE_NAME
/tmp/aws/bin/aws s3 cp $BACKUP_FILE_NAME.gz s3://$S3_BUCKET_PATH/$1/$2/$BACKUP_FILE_NAME.gz
echo "backup $BACKUP_FILE_NAME complete"

