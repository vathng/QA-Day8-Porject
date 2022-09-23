*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${login_button}    //button[@id='dt_login_button']
${tokenLength}    //p[@class='dc-text']//parent::div//ancestor::td
${inputTokenName}    //input[@name='token_name']


*** Keywords ***
Checkbox 
    Click Element    //input[@name='read']//parent::label
    Wait Until Page Contains Element    //input[@name='read' and @value='true']//parent::label

    Click Element    //input[@name='trade']//parent::label
    Wait Until Page Contains Element    //input[@name='trade' and @value='true']//parent::label

    Click Element    //input[@name='payments']//parent::label
    Wait Until Page Contains Element    //input[@name='payments' and @value='true']//parent::label

    Click Element    //input[@name='trading_information']//parent::label
    Wait Until Page Contains Element    //input[@name='trading_information' and @value='true']//parent::label

    Click Element    //input[@name='admin']//parent::label
    Wait Until Page Contains Element    //input[@name='admin' and @value='true']//parent::label




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
    
Navigate to API token page 
    Wait Until Page Does Not Contain Element   //*[@aria-label="Loading interface..."]    10
    Wait Until Page Contains Element    //*[@class="dc-icon"]
    Click Element    //*[@class="dc-icon"]
    Wait Until Element Is Visible    //*[@class="dc-vertical-tab__content dc-vertical-tab__content--floating"]
    Wait Until Page Contains Element    //*[@class="dc-vertical-tab__tab dc-vertical-tab__tab--floating"]
    Wait Until Page Contains Element    /account/api-token
    Click Element    /account/api-token

    Wait Until Element Is Visible    //*[@class="da-api-token__wrapper"]    10
    Wait Until Element Is Visible    //*[@class="da-api-token__timeline"]    10

Checkbox
    Checkbox

    
Uncheck
    Click Element    //input[@name='read']//parent::label
    Wait Until Page Contains Element    //input[@name='read' and @value='false']//parent::label

    Click Element    //input[@name='trade']//parent::label
    Wait Until Page Contains Element    //input[@name='trade' and @value='false']//parent::label

    Click Element    //input[@name='payments']//parent::label
    Wait Until Page Contains Element    //input[@name='payments' and @value='false']//parent::label

    Click Element    //input[@name='trading_information']//parent::label
    Wait Until Page Contains Element    //input[@name='trading_information' and @value='false']//parent::label

    Click Element    //input[@name='admin']//parent::label
    Wait Until Page Contains Element    //input[@name='admin' and @value='false']//parent::label

CheckAll
    Checkbox

Enter Token Name: User enter less than 2 characters
    Click Element    //input[@name='token_name']
    Input Text    //input[@name='token_name']    f
    Click Element    //input[@name='token_name']
    Press Keys    //input[@name='token_name']    CTRL+a+BACKSPACE 
    Element Should Be Disabled    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']
User enter more than 32 characters
    Click Element    //input[@name='token_name']
    Input Text    //input[@name='token_name']    asdfghjtinvhgridkfng234hfytir5432rkfl
    Click Element    //input[@name='token_name']
    Press Keys    //input[@name='token_name']    CTRL+a+BACKSPACE 
    Element Should Be Disabled    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']

User enter invalid format of token name 
    Click Element    //input[@name='token_name']
    Input Text    //input[@name='token_name']    vathng!@#@!#12
    Click Element    //input[@name='token_name']
    Press Keys    //input[@name='token_name']    CTRL+a+BACKSPACE 
    Element Should Be Disabled    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']

User enter valid format of token name & Verify token name 
    Click Element    //input[@name='token_name']
    Input Text    //input[@name='token_name']    vathng12
    ${getTokenName}=    Get Value    ${inputTokenName}
    Element Should Be Enabled    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']
    Wait Until Element Is Enabled    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']
    Click Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button']
    Wait Until Page Contains Element    //*[@class="da-api-token__table-cell da-api-token__table-cell--name"]
    Wait Until Element Is Visible    //*[@class="da-api-token__table-cell da-api-token__table-cell--name"]
    ${verifyTokenName}=    Get Text    //*[@class="da-api-token__table-cell da-api-token__table-cell--name"]
    Should Be Equal    ${verifyTokenName}    ${getTokenName}
    
User copy 
    Wait Until Element Is Visible    //*[@class="da-api-token__table-cell da-api-token__table-cell--name"]    30
    Click Element    //*[@class="dc-icon dc-clipboard"]
    Wait Until Element Is Visible    //*[@class="dc-modal__container dc-modal__container--small dc-modal__container--enter-done"]    10
    Click Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button']


User unmask token
    Wait Until Element Is Visible    //*[@class="da-api-token__table-cell da-api-token__table-cell--name"]    30       
    Click Element    //*[@class="dc-icon da-api-token__visibility-icon"]       
    ${VerifytokenLength}=    GetText     ${tokenLength}   
    Length Should Be    ${VerifytokenLength}    15

User delete token
    Wait Until Page Contains Element    //*[@class="dc-icon dc-clipboard da-api-token__delete-icon"]
    Click Element    //*[@class="dc-icon dc-clipboard da-api-token__delete-icon"]
    Wait Until Element Is Visible    //*[@class="dc-modal__container dc-modal__container--small dc-modal__container--enter-done"]    10
    Wait Until Page Contains Element    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button"]    10    
    Click Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button']
    

    









    
    


    
    
    