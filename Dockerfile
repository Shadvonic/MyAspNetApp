# Use the official ASP.NET Core image as the base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS base
WORKDIR /app
EXPOSE 80

# Use the official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["MyAspNetApp.csproj", "."]
RUN dotnet restore "./MyAspNetApp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "MyAspNetApp.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "MyAspNetApp.csproj" -c Release -o /app/publish

# Build the final image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MyAspNetApp.dll"]






