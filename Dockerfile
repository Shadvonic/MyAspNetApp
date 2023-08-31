FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["MyAspNetApp.csproj", "."]
RUN dotnet restore
COPY . .
WORKDIR "/src/MyAspNetApp"
RUN dotnet build "MyAspNetApp.csproj" -c Release -o /app/build
RUN dotnet publish "MyAspNetApp.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MyAspNetApp.dll"]
