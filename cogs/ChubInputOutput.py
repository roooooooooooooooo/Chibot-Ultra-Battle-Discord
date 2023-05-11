import ASSETS.ascii
import settings
import discord
from discord.ext import tasks, commands


GAME_PATH = settings.GAME_PATH
GAME_OUTPUT = settings.GAME_OUTPUT


class Chibot(commands.Cog):
    def __init__(self, bot):
        self.bot = bot
        self._last_member = None
        self.msg_queue = []

        self.post_msg.add_exception_type(Exception)
        self.post_msg.start()

    @commands.Cog.listener('on_message')
    async def on_message(self, msg: discord.Message, member: discord.Member = None):

        # first setup:
        ctx: commands.Context = await self.bot.get_context(msg)

        # check we're in Labyrinth channel and not a bot:
        if not msg.author.bot:
            #print(f"{msg.author}:  {msg.content}")
            #self.ChubInput(msg)


            # ====
            # user id method:
            # formatted_sn = f"{{id={msg.author.id}}}"
            # new_input = f"{formatted_sn}:  {msg.content}"#.format(msg)
            # print(new_input)  # in {msg.channel.name}".format(msg))

            new_input = f"{{u={msg.author.id}}}:  {msg.content}"

            if settings.DEBUG_MODE:
                print("[INPUT]")
                print(new_input)

            with open(settings.GAME_INPUT, "a") as f:
                f.write(new_input)
                f.write("\n")


    def QSend(self, display):
        self.msg_queue.append(display)


    @tasks.loop(seconds=0.1)  # originally 1
    async def post_msg(self):

        self.ChubOutput()

        chub_output = '\n'.join(self.msg_queue)
        self.msg_queue = []

        if chub_output != "":
            channel = self.bot.get_channel(settings.CHANNEL_CHUB)
            await channel.send(chub_output)


    # OUTPUT
    # scan for each update:
    def ChubOutput(self):
        #outputCache = []
        outputCache = ""

        try:
            with open(settings.GAME_OUTPUT, "r") as f:
                outputCache = f.read()
        except:
                print("file read error #1")
                return

        # Roo's particular formatting:
        outputCache = outputCache.replace("~~", "~")
        outputCache = outputCache.replace("{icon:progtag}", "<~>")
        outputCache = outputCache.replace('~> COMMENCE BATTLE <~', "``` " + ASSETS.ascii.fight + " ```")
        outputCache = outputCache.replace('>> Battle UnPaused <<', "``` " + ASSETS.ascii.fight + " ```")
        outputCache = outputCache.replace("~> Knock It Off, The Battle's Over <~", ASSETS.ascii.game_over)
        outputCache = outputCache.replace("== PAUSED ==", "``` " + ASSETS.ascii.paused + " ```")
        outputCache = outputCache.replace('{icon:kill}', ":crossed_swords:")
        outputCache = outputCache.replace('{icon:death}', ":headstone:")
        outputCache = outputCache.replace('{icon:team}', ":flags:")
        outputCache = outputCache.replace('<br>', "\n")

        # the ID method, which also converts to mentions in the chat.
        while str.find(outputCache, "{u=") > -1: #be sure to loop this until all are reformatted:
            str_start = str.find(outputCache, "{u=")
            str_end = str.find(outputCache, "}", str_start)
            user_id = outputCache[str_start+3:str_end]
            #username = user_id.split("#")
            #username = username[0]
            #this_user = bot.fetch_user(int(user_id))
            #print(f"OUTPUT={outputCache}")
            outputCache = outputCache.replace('{u=' + user_id + '}', f'<@{user_id}>' )

        # Alternatively, the usertag method:
        # # convert to readable username for the chat.
        # while str.find(outputCache, "{u=") > -1:  # be sure to loop this until all are reformatted:
        #     str_start = str.find(outputCache, "{u=")
        #     str_end = str.find(outputCache, "}", str_start)
        #     user_id = outputCache[str_start + 3:str_end]
        #     username = user_id.split("#")
        #     username = username[0]
        #     print(f"OUTPUT={outputCache}")
        #     print(f"userid={user_id}")
        #     outputCache = outputCache.replace('{u=' + user_id + '}', username)

        """ grab a chunk of text that's within the specified limit: """
        outputCacheNext = outputCache[0:800]  # formerly 500
        outputCacheCutoff = outputCacheNext.rfind('\n')
        outputCacheNext = outputCacheNext[0:outputCacheCutoff]
        outputRemaining = outputCache[outputCacheCutoff:]

        if settings.DEBUG_MODE:
            if outputCacheNext.strip() != "":
                print(f"[OUTPUTCACHENEXT]\n{outputCacheNext}")
            if outputRemaining.strip() != "":
                print(f"[OUTPUTREMAAINING]\n{outputRemaining}")


        """ if there's more text beyond what could be sent in one message, write back to the file: """
        if outputCacheNext.strip() != "":
            try:
                with open(settings.GAME_OUTPUT, "w") as f:
                    f.write(outputRemaining)
                    #print("writing remainder to file")
            except:
                print("file read error #2")
                return
        else:
            try:
                with open(settings.GAME_OUTPUT, "w") as f:
                    f.write("")
                    #print("nothing left to output, clearing file")
                if not settings.chub_playing and settings.chub_exiting == True:  # game probably just ended, so finish processing
                    settings.chub_exiting = False  # completely done!
            except:
                print("file read error #3")
                return

        if outputCacheNext.strip() != "":
            self.QSend(outputCacheNext.strip())


# SETUP
async def setup(bot):
    await bot.add_cog(Chibot(bot))
