*** Settings ***
Library    SeleniumLibrary
Resource    ../utils/keywords.robot

Suite Setup    Log    Debut de la suite de tests
Suite Teardown    Log    Fin de la suite de tests
Test Setup    Keywords debut de test
Test Teardown    Close Browser
Test Template    Mon template de test


*** Test Cases ***
1er test OK
    admin    admin
    
Test mauvais login
    adminee    admin    connexion_OK=0
    
Test mauvais mot de passe
    admin    adminee    connexion_OK=0

*** Keywords ***
Keywords debut de test
    Log    Test setup
    Open Browser    http://ats.faimerecruiter.com/    chrome

Mon template de test
    [Arguments]    ${login}    ${password}    ${connexion_OK}=1
    Log    Ceci est ${TEST_NAME}
    Connexion    ${login}    ${password}    connexion_OK=${connexion_OK}