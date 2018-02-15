# npp.connections

<div align="center">
	<a href="https://github.com/vladk1973/npp.connections">
		<img src="https://github.com/vladk1973/npp.connections/blob/master/Notepad%2B%2B%20SQL%20Connection%20Plugin.png">
	</a>
</div>

This plugin allows Notepad++ to connect to MS SQL or Sybase servers. ODBC data sources also supported
npp.connections works with MS SQL data sources, that must be placed like aliases by "SQL Server Configuration Manager" tool
Sybase servers must be placed like aliases in \Sybase\ini\sql.ini file (default configuration inifile in Sybase Client)
After installation two new buttons and two commands in menu are available:
<ul>
<li><b>Show Result panel</b> - show panel with current connections and query results. Use popup menu to add active connection in left side of panel</li>
<li><b>Execute SQL</b> - execute selected text in Notepad++ like a SQL batch. For example, type and select this text: <b>sp_help sysdatabases</b> and then press <b>CTRL+E</b>. Results of this command will be shown in "npp.Connections" panel in special "SQL tab". 
    You can copy SQL results to clipboard, use popup menu</li>
</ul>

## To build npp.connections.dll:
<ol>
<li>Open npp.connections.dpr</li>
<li>Build npp.connections.dll [like a normal Delphi project]</li>
</ol>

## Demo video available <a href="https://github.com/vladk1973/npp.connections/tree/master/Demo">here</a>
