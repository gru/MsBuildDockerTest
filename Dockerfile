FROM mcr.microsoft.com/dotnet/sdk:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["MsBuildDockerTest.csproj", "./"]
RUN dotnet restore "MsBuildDockerTest.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "MsBuildDockerTest.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "MsBuildDockerTest.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MsBuildDockerTest.dll"]
