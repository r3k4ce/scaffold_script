import json, urllib.request
from pathlib import Path

auth = json.loads(Path("~/.codex/auth.json").expanduser().read_text())
token = auth["tokens"]["access_token"]
account = auth["tokens"]["account_id"]

req = urllib.request.Request(
  "https://chatgpt.com/backend-api/wham/rate-limit-reset-credits",
  headers={
    "Authorization": f"Bearer {token}",
    "ChatGPT-Account-ID": account,
    "originator": "Codex Desktop",
  },
)

print(urllib.request.urlopen(req).read().decode())
