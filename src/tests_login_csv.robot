*** Settings ***
Library    SeleniumLibrary
Library    DataDriver    ../data/input_login.csv
Library    ../utils/library_python.py       
Resource    ../utils/keywords.robot

Suite Setup    Log    Debut de la suite de tests
Suite Teardown    Log    Fin de la suite de tests
Test Setup    Keywords debut de test
Test Teardown    Close Browser
Test Template    Mon template de test


*** Variables ***
${commentaire}    0
${login}    0
${password}    0
${connexion_OK}    0

*** Test Cases ***
Test (${commentaire}) avec ${login} et ${password} on a donc connexion=${connexion_OK}
    ${login}    ${password}    ${connexion_OK}

*** Keywords ***
Keywords debut de test
    Log    Test setup
    Open Browser    http://ats.faimerecruiter.com/    chrome

Mon template de test
    [Arguments]    ${login}    ${password}    ${connexion_OK}
    Log    Ceci est ${TEST_NAME}
    ${alors_l_age_du_capitai}=    Ecriture Dans Fichier    output${/}sortie_python.log    Ceci est ${TEST_NAME}
    Connexion    ${login}    ${password}    connexion_OK=${connexion_OK}