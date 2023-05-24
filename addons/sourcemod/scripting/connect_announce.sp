// ███╗░░░███╗░█████╗░░█████╗░███╗░░██╗░██████╗░███████╗████████╗░██████╗██╗░░░██╗
// ████╗░████║██╔══██╗██╔══██╗████╗░██║██╔════╝░██╔════╝╚══██╔══╝██╔════╝██║░░░██║
// ██╔████╔██║██║░░██║██║░░██║██╔██╗██║██║░░██╗░█████╗░░░░░██║░░░╚█████╗░██║░░░██║
// ██║╚██╔╝██║██║░░██║██║░░██║██║╚████║██║░░╚██╗██╔══╝░░░░░██║░░░░╚═══██╗██║░░░██║
// ██║░╚═╝░██║╚█████╔╝╚█████╔╝██║░╚███║╚██████╔╝███████╗░░░██║░░░██████╔╝╚██████╔╝
// ╚═╝░░░░░╚═╝░╚════╝░░╚════╝░╚═╝░░╚══╝░╚═════╝░╚══════╝░░░╚═╝░░░╚═════╝░░╚═════╝░
// -----------------------------------------------------------------------------------------------------------
#include <sourcemod>
#include <geoip>
#include <multicolors>

ConVar g_ConnectMessage;
ConVar g_DisconnectMessage;
ConVar g_cPrefix;

public Plugin:myinfo = 
{
	name = "Connect/Disconnect Announce+",
	author = "Crazy, moongetsu",
	description = "Prints a message in chat when a player joins/leaves",
	version = "2.0",
	url = "https://discord.gg/moongetsu"
};

public OnPluginStart()
{	
	g_ConnectMessage = CreateConVar("ca_connectmsg", "1", "Shows a connect message in the chat once a player joins.");
	g_DisconnectMessage = CreateConVar("ca_disconnectmsg", "1", "Shows a disconnect message in the chat once a player leaves.");
    AutoExecConfig(true, "connect_announce");
    LoadTranslations("connect_announce.phrases");
}

public OnClientPutInServer(client)
{
	new Connect = GetConVarInt(g_ConnectMessage);
	if(Connect == 1)
	{
		new String:name[99];
		GetClientName(client, name, sizeof(name));

        CPrintToChatAll("%t", "connect", name);
    } else {
  
    CloseHandle(g_ConnectMessage);
   }
}

public OnClientDisconnect(client)
{
	new Disconnect = GetConVarInt(g_DisconnectMessage);
	if(Disconnect == 1)
	
	{
		new String:name[99];
		GetClientName(client, name, sizeof(name));

        CPrintToChatAll("%t", "disconnect", name);
    } else {
    
    CloseHandle(g_DisconnectMessage);
    }
}