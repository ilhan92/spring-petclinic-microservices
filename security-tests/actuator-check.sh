#!/bin/bash

TARGET_URL=${TARGET_URL:-"http://localhost:8080"}

echo "Test de sécurité : vérification de /actuator/env"
echo "Cible : $TARGET_URL"

STATUS_CODE=$(curl -s -o /tmp/actuator_env.txt -w "%{http_code}" "$TARGET_URL/actuator/env")

echo "Code HTTP reçu : $STATUS_CODE"

if [ "$STATUS_CODE" = "200" ]; then
  echo "ERREUR SECURITE : /actuator/env est accessible publiquement"
  echo "Faille OWASP A05 Security Misconfiguration détectée"
  exit 1
else
  echo "OK : /actuator/env n'est pas accessible publiquement"
  exit 0
fi