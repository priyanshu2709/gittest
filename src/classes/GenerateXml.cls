global class GenerateXml
{
    webservice static string DomExample()
    {
        Dom.Document doc = new Dom.Document();        
        
        Dom.Xmlnode rootNode = doc.createRootElement('response', null, null);
    
        list<account> accountList = [ 
            select    id, name, 
                    billingStreet, billingCity,
                    billingState, billingPostalCode,
                    billingCountry,
                    shippingStreet, shippingCity,
                    shippingState, shippingPostalCode,
                    shippingCountry,
                    (select id, name, email from Contacts) 
              from    Account limit 1];
              
        for (Account eachAccount : accountList) {
            Dom.Xmlnode accountNode = rootNode.addChildElement('Account', null, null);
            accountNode.setAttribute('id', eachAccount.Id);
            accountNode.setAttribute('name', eachAccount.Name);
            
            if (String.IsNotBlank(eachAccount.billingStreet)) {
                Dom.Xmlnode addressNode = accountNode.addChildElement('Address', null, null);
                addressNode.setAttribute('type', 'Billing');
                addressNode.addChildElement('Street', null, null).addTextNode(eachAccount.billingStreet);
                addressNode.addChildElement('City', null, null).addTextNode(eachAccount.billingCity);
                addressNode.addChildElement('State', null, null).addTextNode(eachAccount.billingState);
                addressNode.addChildElement('PostalCode', null, null).addTextNode(eachAccount.billingPostalCode);
                addressNode.addChildElement('Country', null, null).addTextNode(eachAccount.billingCountry);                
            }
            
            if (String.IsNotBlank(eachAccount.ShippingStreet)) {                
                Dom.Xmlnode addressNode = accountNode.addChildElement('Address', null, null);
                addressNode.setAttribute('type', 'Shipping');
                addressNode.addChildElement('Street', null, null).addTextNode(eachAccount.shippingStreet);
                addressNode.addChildElement('City', null, null).addTextNode(eachAccount.shippingCity);
                addressNode.addChildElement('State', null, null).addTextNode(eachAccount.shippingState);
                addressNode.addChildElement('PostalCode', null, null).addTextNode(eachAccount.shippingPostalCode);
                addressNode.addChildElement('Country', null, null).addTextNode(eachAccount.shippingCountry);                
            }
            
            for (Contact eachContact : eachAccount.Contacts) {
                Dom.Xmlnode contactNode = accountNode.addChildElement('Contact', null, null);
                contactNode.setAttribute('id', eachContact.Id);
                contactNode.setAttribute('name', eachContact.Name);
                contactNode.setAttribute('email', eachContact.Email);
            }
        }
        
        system.debug('debug'+doc.toXmlString());  
        
        return doc.toXmlString();         
    }
    
    webservice static string StreamExample(string token )
    {
        string myToken ='Gandutesting';
        
        if(myToken==token)
        {
         
            XmlStreamWriter writer = new XmlStreamWriter();
            
            writer.writeStartDocument('utf-8', '1.0');        
            writer.writeStartElement(null, 'response', null);
            
            list<account> accountList = [select id,name,billingStreet, billingCity,billingState, billingPostalCode,
                                            billingCountry,
                                        shippingStreet, shippingCity,
                                        shippingState, shippingPostalCode,
                                        shippingCountry,
                                        (select id, name, email from Contacts) from account
                                          where billingpostalcode != '' limit 9 ];
                  
            for (Account eachAccount : accountList) {
                writer.writeStartElement(null, 'Account', null);
                writer.writeAttribute(null, null, 'id', eachAccount.Id);
                writer.writeAttribute(null, null, 'name', eachAccount.Name);
                
                if (String.IsNotBlank(eachAccount.billingStreet)) {
                    writer.writeStartElement(null, 'Address', null);
                    writer.writeAttribute(null, null, 'type', 'Billing');                
                    
                    writer.writeStartElement(null, 'Street', null);
                    writer.writeCharacters(eachAccount.billingStreet);
                    writer.writeEndElement();
                    
                    writer.writeStartElement(null, 'City', null);
                    writer.writeCharacters(eachAccount.billingCity);
                    writer.writeEndElement();
                    
                    writer.writeStartElement(null, 'State', null);
                    writer.writeCharacters(eachAccount.billingState);
                    writer.writeEndElement();
                    
                    writer.writeStartElement(null, 'PostalCode', null);
                    writer.writeCharacters(eachAccount.billingPostalCode);
                    writer.writeEndElement();
                    
                    writer.writeStartElement(null, 'Country', null);
                    writer.writeCharacters(eachAccount.billingCountry);
                    writer.writeEndElement();
        
                    writer.writeEndElement();                
                }
                
                if (String.IsNotBlank(eachAccount.shippingStreet)) {
                    writer.writeStartElement(null, 'Address', null);
                    writer.writeAttribute(null, null, 'type', 'Shipping');                
                    
                    writer.writeStartElement(null, 'Street', null);
                    writer.writeCharacters(eachAccount.shippingStreet);
                    writer.writeEndElement();
                    
                    writer.writeStartElement(null, 'City', null);
                    writer.writeCharacters(eachAccount.shippingCity);
                    writer.writeEndElement();
                    
                    writer.writeStartElement(null, 'State', null);
                    writer.writeCharacters(eachAccount.shippingState);
                    writer.writeEndElement();
                    
                    writer.writeStartElement(null, 'PostalCode', null);
                    writer.writeCharacters(eachAccount.shippingPostalCode);
                    writer.writeEndElement();
                    
                    writer.writeStartElement(null, 'Country', null);
                    writer.writeCharacters(eachAccount.shippingCountry);
                    writer.writeEndElement();
        
                    writer.writeEndElement();                
                }
        
                for (Contact eachContact : eachAccount.Contacts) {
                    writer.writeStartElement(null, 'Contact', null);
                    
                    writer.writeAttribute(null, null, 'id', eachContact.Id);
                    writer.writeAttribute(null, null, 'name', eachContact.Name);
                    writer.writeAttribute(null, null, 'email', eachContact.Email);
                    
                    writer.writeEndElement();
                }
                
                writer.writeEndElement();
            }
            
            writer.writeEndElement();
            
            system.debug(writer.getXmlString());
            
            writer.close(); 
            return writer.getXmlString();           
        }
        return null;
    }
}