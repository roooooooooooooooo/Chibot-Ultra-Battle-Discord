import sys
import settings
import subprocess
from discord.ext import commands

@commands.group()
async def chub(ctx):

    # progTag = progtag.GetProgtag(settings.tagcount)

    level1 = 953472104131608606
    power = ctx.author.get_role(level1)

    if power == None:  # not qualified
        return

    if settings.chub_playing:
        await ctx.send("*STATUS: Chub seems to be running already! Try exiting with (~exit), or see host commands with (~commands).*")
        return

    # run it:
    try:
        result = subprocess.Popen([settings.CHUB_EXE_FILE],shell=True, cwd=settings.GAME_PATH)
            # subprocess.Popen(r'c:\mytool\tool.exe', cwd=r'd:\test\local')
    except:
        print("error running chub exe file?")
    #     print(settings.CHUB_EXE_FILE)

async def setup(bot):
    bot.add_command(chub)