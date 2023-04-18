# Powershell-Scripts

Powershell Scripts for VM Customisations

Use the scripts in this repository with 
Powershell customisers in your Azure 
Compute Gallery customisations


## Silent Git installs

Best option for configuring settings for an unattended git install is:

1. Download the git executable
2. Run the executable with the /SAVEINF=<filename> option
3. The saved file <filename> can now be used with /LOADINF=<filename> in your unattended install

Full options for an unattended install are listed [here](https://jrsoftware.org/ishelp/index.php?topic=setupcmdline):

```
"/NORESTART /VERYSILENT /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /LOG=$BUILD_DIRECTORY\git-for-windows.log /LOADINF=$BUILD_DIRECTORY\add_bash.inf /SUPPRESSMSGBOXES /ALLUSERS"
```
Further info at:

- [StackOverflow](https://stackoverflow.com/questions/73285729/how-can-i-install-git-with-bash-on-powershell-on-powershell)
- [Git for Windows](https://github.com/git-for-windows/git/wiki/Silent-or-Unattended-Installation)
- [New Context](https://github.com/newcontext-oss/add-git/blob/master/Add-Git.psm1)
