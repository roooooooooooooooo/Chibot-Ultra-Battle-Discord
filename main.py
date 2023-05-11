import discord
from discord.ext import commands
import settings


def run():
    intents = discord.Intents.all() #discord.Intents.default()
    intents.message_content = True

    bot = commands.Bot(command_prefix="~", help_command=None, intents=intents, activity=discord.Game("Virtua Space"))


    @bot.event
    async def on_ready():

        # load commands
        for cmd_file in settings.CMDS_DIR.glob("*.py"):
            if cmd_file.name != "__init__.py":
                await bot.load_extension(f"cmds.{cmd_file.name[:-3]}")

        # cogs
        for cog_file in settings.COGS_DIR.glob("*.py"):
                if cog_file.name != "__init__.py":
                    await bot.load_extension(f"cogs.{cog_file.name[:-3]}")

        # loaded
        print(f'>>> Chibot Ultra Battle (Chub) Discord Loaded!')


    # Capture commands outside of main loop:
    # this event will be triggered whenever a message is received
    @bot.event
    async def on_message(msg):
        # GeneralInput is a coroutine, so don't forget to await the call
        #await GeneralInput(msg)

        # to avoid 'commands not working'
        await bot.process_commands(msg)

    # setup:
    bot.run(settings.DISCORD_API_SECRET)

if __name__ == "__main__":
    run()
