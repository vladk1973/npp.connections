# npp.connections

<div align="center">
	<a href="https://github.com/vladk1973/npp.connections">
		<img src="https://github.com/vladk1973/npp.connections/blob/master/Notepad%2B%2B%20SQL%20Connection%20Plugin.png">
	</a>
</div>

This plugin allows Notepad++ to connect to MS SQL or Sybase servers. ODBC data sources are also supported. Npp.connections work with MS SQL data sources that must be placed as aliases by "SQL Server Configuration Manager" tool. Sybase servers must be placed as aliases in \Sybase\ini\sql.ini file (default configuration ini-file in Sybase Client).
After installation there will be two new buttons and two commands available in the menu:
<ul>
<li><b>Show Result panel</b> - show panel with current connections and query results. Use pop-up menu to add an active connection on left side of the panel</li>
<li><b>Execute SQL</b> - execute selected text in Notepad++ as an SQL batch. For example, type and select this text: <b>sp_help sysdatabases</b> and then press <b>CTRL+E</b>. Results of this command will be shown in "npp.Connections" panel in special "SQL tab". 
    You can copy SQL results to clipboard using pop-up menu</li>
</ul>

## To build npp.connections.dll:
<ol>
<li>Open npp.connections.dpr</li>
<li>Build npp.connections.dll [as a normal Delphi project]</li>
</ol>

## Demo video available <a href="https://github.com/vladk1973/npp.connections/tree/master/Demo">here</a>
