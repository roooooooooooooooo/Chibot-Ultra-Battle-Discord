import os
import pathlib
from dotenv import load_dotenv
import json

BASE_DIR = pathlib.Path(__file__).parent
CMDS_DIR = BASE_DIR / "cmds"
COGS_DIR = BASE_DIR / "cogs"

# load settings
f = open("settings.json")
settings = json.load(f)

load_dotenv()
DISCORD_API_SECRET = os.getenv("DISCORD_API_TOKEN")

# CONFIG
DEBUG_MODE = False
CHANNEL_CHUB = settings["discord_channel_id"]  # rightclick on channel in discord > Copy Channel ID

# CHUB
GAME_PATH = BASE_DIR / "ASSETS" / "chub2k23 Discord"
CHUB_EXE = "chub2k23.exe"
CHUB_EXE_FILE = GAME_PATH / CHUB_EXE
chub_playing = False
chub_exiting = False

GAME_OUTPUT = GAME_PATH / "game.txt"
GAME_INPUT = GAME_PATH / "input.txt"


