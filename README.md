# Script_Powershell

Mon_script1 :
Le script permet la création d'un dossier nommé "temp" situé dans le répertoire courant
et créera par la suite un total de 200 fichiers avec l'extension .log et avec un message situé à l'intérieur

Mon_script2 :
Le script permet la suppression de fichier avec l'extension .log tout en passant par une demande
à l'utilisateur d'indiquer le chemin du dossier contenant les fichier et ensuite passe par
une vérification de celui-ci

Mon_script3 :
Le script est un gestionnaire de fichier et de dossier contenant plusieurs options d'action :
Option 1 -> Création d'un fichie. L'utilisateur rentre le nom du fichier qu'il veut créer
            qui se situera dans le répertoire courant
Option 2 -> Création d'un dossier. L'utilisateur entre un chemin et un nom ensuite le script va
            vérifier que le chemin existe puis créer le dossier
Option 3 -> Affichage du contenu d'un fichier. L'utilisateur entre un chemin et un nom de fichier, le script vérifie 
            que le chemin existe puis affiche le contenu du fichier
Option 4 -> Listage du contenu d'un fichier. L'utilisateur entre un chemin, 
            le script vérifie qu'il existe puis liste tous les fichiers et dossiers présents
Option 5 -> Permet de sortir du script

Mon_script4 :
Le script permet de réaliser différentes opérations
Option 1 -> Permet de réaliser la somme des deux nombres que l'utilisateur a choisi
Option 2 -> Permet de réaliser la soustraction des deux nombres que l'utilisateur a choisi
Option 3 -> Permet de réaliser le produit des deux nombres que l'utilisateur a choisi
Option 4 -> Permet de réaliser la division des deux nombres que l'utilisateur a choisi
Option 5 -> Permet de sortir du script
Pour finir il enregistre tous les calcul réalisé dans un fichier d'historique qu'il a créé
sinon, il réutilise le même

Mon_script5 :
Ce script est un gestionnaire d'utilisateur locaux possédant différente action pouvant être réalisé :
Option 1 -> Création de l'utilisateur. L'utilisateur rentre le fichier contenant les utilisateur,
            ensuite le script vérifie si le chemin du fichier est bon, après cela il le créer avec le
            mot de passe "caribou23" et l'ajoute au groupe "adm" ou "user" 
Option 2 -> Suppression de l'utilisateur. Pareil que l'option 1 mais cette fois-ci il supprime le ou les
            utilisateur présent dans le fichier
Option 3 -> Permet de sortir du script
Ensuite le script créer automatiquement un fichier où sera stocké l'historique des actions effectué par celui-ci
donc la création et la suppression d'utilisateur

Mon_script6 :
Le script permet d'effectuer des ping automatiquement pour tester si les noms des machines renseignées dans le fichier peuvent établir une connection
Etape 1 -> Lecture du fichier contenant la liste des noms des machines qui est transmis par l'utilisateur 
           passant par une vérification du chemin de celui-ci  
Etape 2 -> Création du rapport, si le fichier contenant le rapport existe déjà alors il le modifiera
Etape 3 -> Initialisation des deux variable "$Joignable" et "NJoignable", permettant d'effectuer un comptage des 
           machines qui seront oui ou non joignable
Etape 4 -> Envoie d'un ping aux macchines pour tester si elles répondent ou non ce qui incrémentera la valeur des nos 
           deux variables établie dans l'étape précedente

Mon_script7 :
Le script permet d'effectuer un scan réseau permettant de détecter les adresses IP libres et occupées dans le réseau  local
Option 1 -> Lancement du scan réseau, le script récupère automatiquement l'adresse IP local de la machine sur lequel 
            le script a été exécuté en cherchant sur les interface Ethernet et WIFI tout en exluant les adresses 
            commençant par 169 car se sont des adresses faites automatiquement par Windows et sont donc sans réseau.
            Ensuite il extrait les 3 premier octets de l'adresse pour en construire une plage réseau
            Et pour finir il effectue un ping sur un total de 254 adresses possible dans le réseau pour détecter si
            celle-ci est libre ou non (une machine n'autorisant pas le ping verra donc son adresse en Libre ce qui
            peut poser problème quand à la fiabilité du script)
Option 2 -> Listage d'un fichier contenant les adresses IP et leur disponibilité (Libre ou Occupée)
