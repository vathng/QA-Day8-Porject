*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${link}    //a[@class='link']
@{closeAccReason}

*** Test Cases ***
Login To Deriv
    Open Browser    https://app.deriv.com/    chrome
    Maximize Browser Window
    Wait Until Page Does Not Contain Element   //*[@aria-label="Loading interface..."]    10
    Wait Until Page Contains Element    dt_login_button   60
    Click Element    dt_login_button
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']    shin.cheng@besquare.com.my 
    Input Text    //input[@type='password']    HondaHRV2022!!!
    Click Element    //button[@type='submit']

Navigate to account setting page 
    Wait Until Page Does Not Contain Element   //*[@aria-label="Loading interface..."]    10    #loading account
    Wait Until Page Contains Element    //*[@class='sidebar__items']    20    #loading contract sidebar
    Wait Until Page Contains Element    dt_core_account-info_acc-info    40    #loading account info

Navigate to close account page 
    Wait Until Page Does Not Contain Element   //*[@aria-label="Loading interface..."]    10
    Wait Until Page Contains Element    //*[@class="dc-icon"]
    Click Element    //*[@class="dc-icon"]
    Wait Until Element Is Visible    //*[@class="dc-vertical-tab__content dc-vertical-tab__content--floating"]
    Wait Until Page Contains Element    //*[@class="dc-vertical-tab__tab dc-vertical-tab__tab--floating"]
    Wait Until Page Contains Element    /account/api-token
    Click Element    /account/closing-account

Security and privacy policy 
    Wait Until Element Is Visible    //*[@class="dc-vertical-tab__content dc-vertical-tab__content--floating"] 
    Page Should Contain Link    ${link}

Close Account: User do not select any checkbox
    Click Element    //button[@class='dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account']
    Wait Until Element Is Visible    //*[@class="dc-vertical-tab__content-container"]    5
    Click Element    //*[@class="dc-input closing-account-reasons__input"]    
    Element Should Be Disabled    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large']

Close Account: Use select checkbox 
    Click Element    //input[@name='financial-priorities']//parent::label
    Wait Until Page Contains Element    //input[@name='financial-priorities' and @value='true']//parent::label
    Click Element    //input[@name='financial-priorities']//parent::label
    #Wait Until Page Contains Element    //input[@name='financial-priorities' and @value='false']//parent::label

    
    

