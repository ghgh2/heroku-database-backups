import requests
import os

r = requests.get("https://api.heroku.com/users/" + os.environ["HEROKU_TOOLBELT_API_EMAIL"] + "/addons",
    headers={
        "Accept": "application/vnd.heroku+json; version=3"
    }
).json()

for addon in r:
    if addon["addon_service"]["name"] == "heroku-postgresql":
        os.system(" ".join(["bash /app/bin/db.sh", addon["app"]["name"], addon["name"]]))
