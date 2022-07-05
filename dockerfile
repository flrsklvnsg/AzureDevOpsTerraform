# Get Base Image (Full .NET Core SDK)
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy csproj and restore
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "weatherapi.dll"]

# # https://hub.docker.com/_/microsoft-dotnet
# FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
# WORKDIR /app

# # copy csproj and restore as distinct layers
# COPY *.csproj ./
# # COPY app/*.csproj ./app/
# RUN dotnet restore

# # copy everything else and build app
# COPY . ./
# WORKDIR /app
# # RUN dotnet publish -c release -o /app --no-restore
# RUN dotnet publish -c Release -o out

# # final stage/image
# FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine
# WORKDIR /app
# COPY --from=build /app ./
# ENTRYPOINT ["dotnet", "weatherapi.dll"]