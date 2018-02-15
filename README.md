# npp.connections
This plugin allows Notepad++ to connect to MS SQL or Sybase servers. ODBC data sources also supported
npp.connections works with MS SQL data sources, that must be placed like aliases by "SQL Server Configuration Manager" tool
Sybase servers must be placed like aliases in \Sybase\ini\sql.ini file (default configuration inifile in Sybase Client)
After installation two new buttons and two commands in menu are available:
 1. Show Result panel - show panel with current connections and query results. Use popup menu to add active connection in left side of panel.
 2. Execute SQL - execute selected text in Notepad++ like a SQL batch. For example, type and select this text: sp_help sysdatabases
    And then press CTRL+E. Results of this command will be shown in "npp.Connections" panel in special "sql tab". 
    You can copy SQL results to clipboard, use popup menu.


To build plugin from source:
-------------------------------

## To build "npp.connections.dll":

 1. Open npp.connections.dpr
 2. Build npp.connections.dll [like a normal Delphi project]

