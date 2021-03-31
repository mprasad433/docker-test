#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

#FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
FROM mcr.microsoft.com/dotnet/aspnet:5.0-windowsservercore-ltsc2019
WORKDIR /app
EXPOSE 80
COPY ./bin/Release/net5.0/publish ./
#########################################
# set shell parameters, to stop on error
#########################################

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

##############################
# Install vc++ 2013/2019
##############################

RUN Start-Process vcredist_x64.exe -ArgumentList '/install /quiet /log vs_2019_log.txt' -Wait
ENTRYPOINT ["dotnet", "DotNet5API.dll"]