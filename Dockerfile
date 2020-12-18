#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
WORKDIR /src
COPY ["PrimeNumbers.OnDemandFinder.API/PrimeNumbers.OnDemandFinder.API.csproj", "PrimeNumbers.OnDemandFinder.API/"]
COPY ["NuGet.Config", "."]
RUN dotnet restore "PrimeNumbers.OnDemandFinder.API/PrimeNumbers.OnDemandFinder.API.csproj"
COPY . .
WORKDIR "/src/PrimeNumbers.OnDemandFinder.API"
RUN dotnet build "PrimeNumbers.OnDemandFinder.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PrimeNumbers.OnDemandFinder.API.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "PrimeNumbers.OnDemandFinder.API.dll"]
