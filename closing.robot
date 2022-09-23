*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${link}    //a[@class='link']
@{closeAccReason} =    financial-priorities    stop-trading    not-interested    another-website    not-user-friendly    difficult-transactions    lack-of-features    unsatisfactory-service    other-reasons

*** Test Cases ***
Login To Deriv
    Open Browser    https://app.deriv.com/    chrome
    Maximize Browser Window
    Wait Until Page Does Not Contain Element   //*[@aria-label="Loading interface..."]    10
    Wait Until Page Contains Element    dt_login_button   60
    Click Element    dt_login_button
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']    
    Input Text    //input[@type='password']    
    Click Element    //button[@type='submit']

Navigate to account setting page 
    Wait Until Page Does Not Contain Element   //*[@aria-label="Loading interface..."]    30    #loading account
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

Close Account: User do not select any checkbox and input text field
    #User click on Close Account button and direct user to close account page 
    Click Element    //button[@class='dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account'] 
    Wait Until Element Is Visible    //*[@class="dc-vertical-tab__content-container"]    30
    
    #User click on Back button and redirect user back to close account confirmation page
    Click Element    //button[@class='dc-btn dc-btn__effect dc-btn--secondary dc-btn__large']
    Wait Until Element Is Visible    //*[@class="dc-vertical-tab__content-container"]    30

    #User click on Close Account button and direct user to close account page
    Click Element    //button[@class='dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account']
    Wait Until Element Is Visible    //*[@class="dc-vertical-tab__content-container"]    5
    
    #User click on input field without tick on any checkbox 
    Click Element    //*[@class="dc-input closing-account-reasons__input"]    
    Element Should Be Disabled    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large']

Close Account: Verify checkbox 

#Check and uncheck every single checkbox one by one 
    FOR    ${reason}    IN    @{closeAccReason}
    Click Element    //input[@name='${reason}']//parent::label
    Checkbox Should Be Selected    //input[@name='${reason}']
    Wait Until Page Contains Element   //input[@name='${reason}' and @value='true']//parent::label    30

    Click Element    //input[@name='${reason}']//parent::label
    Checkbox Should Not Be Selected    //input[@name='${reason}']
    Wait Until Page Contains Element   //input[@name='${reason}' and @value='false']//parent::label    30
    END

#Check 3 checkbox
    Click Element    //input[@name='financial-priorities']//parent::label
    Wait Until Page Contains Element    //input[@name='financial-priorities' and @value='true']//parent::label    10

    Click Element    //input[@name='stop-trading']//parent::label
    Wait Until Page Contains Element    //input[@name='stop-trading' and @value='true']//parent::label    10

    Click Element    //input[@name='not-interested']//parent::label
    Wait Until Page Contains Element    //input[@name='not-interested' and @value='true']//parent::label    10

 Close Account: Text area input
 #User input invalid format of text for the first text box     
    Wait Until Element Is Visible    //*[@class="dc-input closing-account-reasons__input"]    10
    Click Element    //*[@class="dc-input closing-account-reasons__input"]
    Input Text    //textarea[@name='other_trading_platforms']    fffwd@@@!@#21
    Element Should Be Disabled    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
    Wait Until Page Contains Element    //*[@class="dc-text closing-account-reasons__error"]    5
    Press Keys    //textarea[@name='other_trading_platforms']    CTRL+a+BACKSPACE

#User input valid format of text for the first text box
    Input Text    //textarea[@name='other_trading_platforms']    dkncmjdvm, dkmckdmc, cmdmcd, kdmckdmc, dkmcdkmc, dmcjdvd-djcndvj,dcmdkmvifmv.dkvmdvmfkmvfk.vjfmvfkvm,vjdnvfmc.
    Element Should Be Enabled    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
    Press Keys    //textarea[@name='other_trading_platforms']    CTRL+a+BACKSPACE

#User input valid format of text for the first text box & user input invalid format of text for the second text box 
    Input Text    //textarea[@name='other_trading_platforms']    dkncmjdvm, dkmckdmc, cmdmcd, kdmckdmc, dkmcdkmc, dmcjdvd-djcndvj,dcmd.
    Wait Until Element Is Visible    //*[@class="dc-input closing-account-reasons__input"]
    Input Text    //textarea[@name='do_to_improve']    dwswd!@3fef
    Element Should Be Disabled    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]

#User input valid format of text for the second text box    
    Press Keys    //textarea[@name='do_to_improve']    CTRL+a+BACKSPACE
    Input Text    //textarea[@name='do_to_improve']    dfef, defe,f fefef, fefefef.fefefdefffd.
    Element Should Be Enabled    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"] 

#User click on close account button & confirmation box pop up
    Click Element    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"] 
    Wait Until Element Is Visible    //*[@class="dc-modal__container dc-modal__container_closing-account-reasons dc-modal__container--enter-done"]

    




    

    
    

