import sys
import settings
import subprocess
from discord.ext import commands

@commands.group()
async def chub(ctx):

    level1 = 953472104131608606
    power = ctx.author.get_role(level1)

    if power == None:  # not qualified
        return

    if settings.chub_playing:
        await ctx.send("*STATUS: Chub seems to be running already! Try exiting with (~exit), or see host commands with (~commands).*")
        return

    # run it:
    try:
        await ctx.send("*(Loading...)*")
        result = subprocess.Popen([settings.CHUB_EXE_FILE],shell=True, cwd=settings.GAME_PATH)
    except:
        print("error running chub exe file?")
    #     print(settings.CHUB_EXE_FILE)

async def setup(bot):
    bot.add_command(chub)