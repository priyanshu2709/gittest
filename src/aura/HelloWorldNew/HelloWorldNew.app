<aura:application access="GLOBAL" extends="force:slds">
    <!--this attribute is used to fetch values from URL-->
    <aura:attribute name="whom" type="String" default="world"/>
   <!--Hello {!v.whom}!-->
    <!--<c:initialLightningComponent ></c:initialLightningComponent>-->
    <!--<aura:dependency resource="c:ContactLightning"/>-->
    <!--progress indicator -->
    <!--<c:MyFirstLightningComp ></c:MyFirstLightningComp>-->
    <!--this component is used to handle comtact events-->
   	<!--<c:ContactLightning ></c:ContactLightning>-->
    <!--This component is used to show hide text using toggle-->
    <!--<c:ShowHide></c:ShowHide>-->
    <!--This component is used to take inputfrom user-->
    <!--<c:ApexServerSide1 ></c:ApexServerSide1>-->
    <!--this component is used to display data from backend we have used salesforce lightning css-->
    <!--<c:contacts></c:contacts>-->
    <!--we have used bootstrap css in it-->
    <!--<c:contactsBootstraptable></c:contactsBootstraptable>-->
    <!--this component is used to handle initial events -->
    <!--<c:handleEnent></c:handleEnent>-->
    <!-- Event handle in component-->
    <!--<c:ceHandler ></c:ceHandler>-->
    <!--inheritance-->
    <!--<c:sub ></c:sub>-->
    <!--Token example 1-->
    <!--<c:tokenexample1 />-->
    <!--caching component-->
    <!--<c:cachingcomponent></c:cachingcomponent>-->
    <!--input select-->
    <!--<c:Inputselect ></c:Inputselect>-->
    <!--table-->
    <!--<c:iterationonTable></c:iterationonTable>-->
    
    <!--<c:eventBubblingParent ></c:eventBubblingParent>-->
    <!--<c:AccountListWithEvents ></c:AccountListWithEvents>-->
    	<!--<c:EditOpportunityProduct ></c:EditOpportunityProduct>-->
    <!--<c:LightningLookup objectName="Account" field_API_text="name" field_API_val="id" field_API_search="Name"></c:LightningLookup>-->
    <c:helloWorld ></c:helloWorld>
    <!--<c:CustomSalesPath stageList="['1','2','3']" currentStage="2"/>-->
    <!--<c:MTM_CredentialingExport/>-->
</aura:application>