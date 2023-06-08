# Chibot-Ultra-Battle-Discord
CHuB for Discord

# Quick start
Who carez about details?? Here's how you jump in and start playing right now...


1) create a file called ".env" file in the root directory, and in it, add only this line:
DISCORD_API_TOKEN = [your discord bot's token]

2) open settings.json and set the discord_channel_id to the, you know, discord channel id of the channel where you want the bot to send messages

3) Run the Discord host by running chub_discord.bat

4) Run Chub by either sending (~chub) in your Discord channel, or manually running ASSETS/chub2k23 Discord/chub2k23.exe. If it fails to run, rightclick, hit properties, set compatibility mode to Windows XP Service Pack 3

5) Wait for Chub to load the dataset, then select characters with (.charactername)
6) if you want to add a random bot, use (~cpu)
7) start the pre-game with (~begin), and then when ready, use (~unpause) to actually start the match


# What's been changed?
The Chub version is mostly the same as it was in that initial source code release.

I fixed some of the more showstopping bugs and tried to make it more "c-com" ("chat command") friendly so you can organize and start a standard FFA match only through typing in the discord chat; I have the game running on an AWS Windows cloud server and it's playable without having to log in and touch the GUI at all, unless you want to fine-tune some things like team options. 

I added a bunch of formatting tweaks to the game's ascii tags, a few strings where you insert emojis, stuff like that. You can further tweak the formatting by editing ChubInputOutput.py, or by editing the "default.ini" dataset file (or by making your own).

I also added a feature in the options, enabled by default, to get a random arena choice on each match.

Use (~commands) to see host commands; all host commands are issued with a tilde (~), while game commands are controlled with a period (.)



# Notes
There are lots of character files and a lot of them (like many of the Pokemon) are incomplete and will crash the game, so I left them out of the default dataset. 

