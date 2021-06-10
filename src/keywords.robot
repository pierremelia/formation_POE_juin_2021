*** Settings ***
Library    SeleniumLibrary
Resource    objets.robot

*** Keywords ***
Connexion
    [Arguments]    ${login}    ${password}    ${connexion_OK}=1
    [Documentation]    Ceci est un keyword pour la connexion.
    ...    Il suffit de rentrer son login et password
    ...    avec les arguments adequats.
    Log    ALors voici mon login=${login} et passsword=${password}
    Wait Until Page Contains Element    xpath=//input[@id="username"]
    Page Should Not Contain    Logout    
    Input Text    xpath=//input[@id="username"]    ${login}
    Input Password    xpath=//input[@id="password"]    ${password}
    Click Element    xpath=//input[@class="button" and @type="submit"]
    Run Keyword If    ${connexion_OK} == 1    Wait Until Page Contains    Logout
    Run Keyword If    ${connexion_OK} == 0    Wait Until Page Contains Element    xpath=//p[@class="failure" and text()="Invalid username or password."]
    
    
Ouvrir Onglet
    [Arguments]    ${nom_onglet}    ${tps_attente}=0    ${autre_parametre_optionnel}=false
    [Documentation]    Keywword pour la sélection d un onglet selon l argument choisi.
    
    Log    Ceci est mon keyword "Ouvrir Onglet"
    Log    Tps_attente=${tps_attente} autre_parametre_optionne=${autre_parametre_optionnel}
    Wait Until Page Contains Element    xpath=//div[@id="header"]//ul[@id="primary"]//a[text()="${nom_onglet}"]
    Run Keyword If    ${tps_attente} != 0    Sleep    ${tps_attente}s
    Click element    xpath=//div[@id="header"]/ul[@id="primary"]//a[text()="${nom_onglet}"]
    Wait Until Page Contains Element    xpath=//div[@id="header"]/ul[@id="primary"]//a[text()="${nom_onglet}" and @class="active"]
    
Creer Job Orders
    [Arguments]    ${job_title}    ${job_company}    ${job_city}    ${job_state}    ${job_recruiter}    ${job_owner}    ${job_type}    ${job_openings}    ${job_description}
    #Ici pour etre sur d'etre dans l'onglet Job orders
    ${job_orders_active}=    Get Element Count    xpath=//div[@id="header"]/ul[@id="primary"]//a[text()="Job Orders" and @class="active"]
    Run Keyword If    ${job_orders_active} == 0    Ouvrir Onglet    Job Orders
    Wait Until Page Contains Element    xpath=//div[@id="header"]//ul[@id="primary"]//ul[@id="secondary"]//a[text()="Add Job Order"]
    Click Element    xpath=//div[@id="header"]//ul[@id="primary"]//ul[@id="secondary"]//a[text()="Add Job Order"]    
    #Attendre ouverture fenetre
    Wait Until Page Contains Element    xpath=//div[@id="popupInner"]
    
    Select Frame    xpath=//iframe[@id="popupFrameIFrame"]
    Wait Until Page Contains Element    xpath=//input[@class="button" and @value="Create Job Order"]
    Click Element    xpath=//input[@class="button" and @value="Create Job Order"]
    Unselect Frame
    Wait Until Page Contains    Job Orders: Add Job Order
    
    Remplir Informations Job Orders    ${job_title}    ${job_company}    ${job_city}    ${job_state}    ${job_recruiter}    ${job_owner}    ${job_type}    ${job_openings}    ${job_description}
    
    
    # Appuyer bouton valider
    Wait Until Page Contains Element    xpath=//input[@name="submit"]    
    Capture Page Screenshot
    Click Element    xpath=//form[@name="addJobOrderForm"]//input[@name="submit"]

Modifier Job Orders
    [Arguments]    ${old_job_title}    ${new_job_title}    ${job_company}    ${job_city}    ${job_state}    ${job_recruiter}    ${job_owner}    ${job_type}    ${job_openings}    ${job_description}
    #Ici pour etre sur d'etre dans l'onglet Job orders
    ${job_orders_active}=    Get Element Count    xpath=//div[@id="header"]/ul[@id="primary"]//a[text()="Job Orders" and @class="active"]
    Run Keyword If    ${job_orders_active} == 0    Ouvrir Onglet    Job Orders
    
    Wait Until Page Contains Element    xpath=(//table[@class="sortable"]//a[text()="${old_job_title}"])[1]
    Click Element    xpath=(//table[@class="sortable"]//a[text()="${old_job_title}"])[1]    
    Wait Until Page Contains    Job Orders: Job Order Details
    Click Element     xpath=//div[@id="actionbar"]//a[@id="edit_link"]
    Remplir Informations Job Orders    ${new_job_title}    ${job_company}    ${job_city}    ${job_state}    ${job_recruiter}    ${job_owner}    ${job_type}    ${job_openings}    ${job_description}
    
    Click Element    ${bouton_valider_formulaire_modif_job_order}

Remplir Informations Job Orders
    [Arguments]    ${job_title}    ${job_company}    ${job_city}    ${job_state}    ${job_recruiter}    ${job_owner}    ${job_type}    ${job_openings}    ${job_description}
    # Remplir Title
    Wait Until Page Contains Element    xpath=//table[@class="editTable"]//input[@id="title"]
    Input Text    xpath=//table[@class="editTable"]//input[@id="title"]    ${job_title}        
    
    # Si company= Internal Posting alors on selectionne la checkbox sinon remplir company
    Run Keyword If    '${job_company}' == 'Internal Posting'    Run Keywords
        ...    Log    on a internal posting...
        ...    AND    Select Radio Button    typeCompany    defaultCompany
    ...    ELSE    Run keywords
        ...    Log    on n'a pas internal posting...
        #...    AND    Page Should Contain Element    xpath=//table[@class="editTable"]//input[@id="companyID" and @value="0"]
        ...    AND    Click Element    xpath=//input[@name="typeCompany" and not(@id="defaultCompany")]        
        ...    AND    Input Text    xpath=//table[@class="editTable"]//input[@id="companyName"]    ${job_company}
        ...    AND    Wait Until Element Is Visible    xpath=//div[@id="suggest0" and text()="${job_company}"]
        ...    AND    Sleep    500ms
        ...    AND    Click Element    xpath=//div[@id="suggest0" and text()="${job_company}"]
        ...    AND    Sleep    2s

    Capture Page Screenshot    
    # Remplir ${job_city}
    Input Text    xpath=//table[@class="editTable"]//input[@id="city"]    ${job_city}    
    Capture Page Screenshot
    # remplir ${job_state}
    Input Text    xpath=//table[@class="editTable"]//input[@id="state"]    ${job_state}
    Press Keys    None    TAB
    Capture Page Screenshot
    
    # remplir ${job_recruiter}
    Select From List By Label    xpath=//table[@class="editTable"]//select[@id="recruiter"]    ${job_recruiter}
    Capture Page Screenshot
   
    #    ${job_owner}
    Select From List By Label    xpath=//table[@class="editTable"]//select[@id="owner"]    ${job_owner}
    
    Capture Page Screenshot
    #${type}
    Select From List By Value    xpath=//table[@class="editTable"]//select[@id="type"]    ${job_type}
    Capture Page Screenshot
   
    #${job_openings}
    Input Text    xpath=//table[@class="editTable"]//input[@id="openings"]    ${job_openings}
    Capture Page Screenshot
    # REmplir la description
    Remplir Description Job Orders    ${job_description}
    Capture Page Screenshot
    
Remplir Description Job Orders
    [Arguments]    ${la_description}
    Wait Until Page Contains Element    xpath=//iframe[@title="Éditeur de texte enrichi, description"]
    Select Frame    xpath=//iframe[@title="Éditeur de texte enrichi, description"]
    Input Text    xpath=//body[@class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders"]    ${la_description}
    Unselect Frame