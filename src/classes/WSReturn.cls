global class WSReturn {
    
    webservice static String Hello(String name){
        String sayHello;
        
        sayHello = 'Hi ' + name;
        System.debug('sayHello');
        
        return sayHello;
        
        
    }

}