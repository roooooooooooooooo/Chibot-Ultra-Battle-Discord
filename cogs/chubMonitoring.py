from discord.ext import tasks, commands
import settings
#from pymem import Pymem
import psutil


def is_process_running(name):
    for process in psutil.process_iter():
        try:
            if process.name() == name:
                return True
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            pass
    return False


class ChubBot(commands.Cog):
    def __init__(self, bot):
        self.playing = True
        self.Monitor.start()
        self.bot = bot


    def cog_unload(self):
        self.playing.cancel()

    @tasks.loop(seconds=0.2)
    async def Monitor(self):

        # check if chub's actually running (pymem method)
        # try:
        #     pm = Pymem(CHUB_EXE)
        #     settings.chub_playing = True
        # except:
        #     if settings.chub_playing == True:
        #         settings.chub_exiting = True # just exited, so set this to finish processing the output
        #     settings.chub_playing = False

        #exe = settings.CHUB_EXE_FILE.split("/")

        if is_process_running(settings.CHUB_EXE):
            # print("running")
            settings.chub_playing = True
        else:
            # print("not running")
            if settings.chub_playing == True:
                settings.chub_exiting = True  # just exited, so set this to finish processing the output
                settings.chub_playing = False

        if not settings.chub_playing and not settings.chub_exiting:
            return


# SETUP
async def setup(bot):
    await bot.add_cog(ChubBot(bot))
