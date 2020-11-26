# Instructions to install dependencies and run the code

We assume that the GIFT code is under `/path/to/qsharp/gift`.

## Dependencies

These will be installed as part of the commands in the Environment setup section below.
- dotnet core sdk 2.1,
- qsharp sdk 0.7.1905.3109 (later versions will need changes to the C# code portions),
- iqsharp,
- python 3,
- python qsharp package,
- FileHelpers dotnet package.

## Environment setup

The following should work the same on Windows and Linux, with the minor differences noted below.

- Get the dotnet core sdk version 2.1 from https://www.microsoft.com/net/download.
- Install it following the instructions for the appropriate OS.
- Install python 3 (with pip and jupyter).
- Run the following commands in cmd/shell.

First install Q# and IQ# support.

```
dotnet new -i Microsoft.Quantum.ProjectTemplates
dotnet tool install -g Microsoft.Quantum.IQSharp --version 0.7.1905.3109
```

In theory, on Linux the last command should add `~/.dotnet/tools` to the PATH. Starting a new bash process without rebooting *does not seem to work*, but logging out and in does.
If not, a patch can be to explicitly modify the PATH on demand by running some of the commands as `PATH=$PATH:~/.dotnet/tools command`.

Instead, on Windows, opening a new instance of cmd.exe or PowerShell should be enough.

Get python3 support (on windows you may want to write `py -m pip` instead of `pip3`).

An implicit dependency to get python3 support is to install Jupyter.
This can be done in many ways, varying from system to system. One conservative and hopefully portable possibility is to run the following.
```
pip3 install jupyter --user
```

We now get the qsharp python package.
NOTE: the difference in qsharp versions is intended.
```
pip3 install qsharp==0.8.1907.1701 --user --upgrade
```
On Linux, one may need to log out and in again for the next command to work.

Install iqsharp jupyter support; this may need a Linux PATH override.
```
dotnet iqsharp install --user
cd /path/to/qsharp/gift
```

## How to build
```
cd /path/to/qsharp/gift
dotnet build
```

## How to compute cost estimates
```
cd /path/to/qsharp/gift
dotnet run --no-build
```

