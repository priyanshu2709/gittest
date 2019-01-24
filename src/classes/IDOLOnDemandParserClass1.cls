public class IDOLOnDemandParserClass1 {

    public static String[] parseLanguageDetectionResponse(String response){
        
        JSONParser parser = JSON.createParser(response);
        String languageSummary = '';
        String language_iso639_2b = '';
        
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'language')) {
                    parser.nextToken();
                    String language = parser.getText();
                    languageSummary += '\r\nlanguage: '+language;
                }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'language_iso639_2b')) {
                    parser.nextToken();
                    language_iso639_2b = parser.getText();
                    languageSummary += '\r\nlanguage_iso639_2b: '+language_iso639_2b;
                }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'encoding')) {
                    parser.nextToken();
                    languageSummary += '\r\nencoding: '+parser.getText();
                }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'unicode_scripts')) {
                    parser.nextToken();
                    languageSummary += '\r\nunicode_script: ' + parser.getText() + ',';
                }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'additional_metadata')) {
                    parser.nextToken();
                    languageSummary += '\r\nadditional_metadata: ' + parser.getText() + ',';
                }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'wikipedia_id')) {
                    parser.nextToken();
                    languageSummary += '\r\nwikipedia_id: ' + parser.getText() + ',';
                }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'wikipedia_eng')) {
                    parser.nextToken();
                    languageSummary += '\r\nwikipedia_eng: ' + parser.getText() + ',';
                }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'image')) {
                    parser.nextToken();
                    languageSummary += '\r\nimage: ' + parser.getText() + ',';
                }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'language_nativespeakers')) {
                    parser.nextToken();
                    languageSummary += '\r\nlanguage_nativespeakers: ' + parser.getText() + ',';
                }
        }
        languageSummary += '\r\n\r\n';
        String[] detectedLanguages = new List<String>{language_iso639_2b, languageSummary};
        return detectedLanguages;
    }
    
    public static String[] parseSentimentAnalysisResponse(String response){
        
        JSONParser parser = JSON.createParser(response);
        
        String aggregateScore = '';
        String score = '';
        String sentiment = '';
        
        String summary = '\r\nSentiment Analysis:\r\n';
        
        while (parser.nextToken() != null) {
                        
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getCurrentName() == 'positive')) {
                summary += '\r\n--positive--\r\n';
                parser.nextToken();
                if (parser.getCurrentToken() == JSONToken.START_ARRAY){
                    while (parser.nextToken() != JSONToken.END_ARRAY) {
                        if (parser.getCurrentToken() == JSONToken.START_OBJECT){
                            
                            while (parser.nextToken() != JSONToken.END_OBJECT) {
                                
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'sentiment')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_STRING){
                                        String sentiment2 = parser.getText();
                                        summary += 'sentiment: '+sentiment2+', ';
                                    }
                                }
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'topic')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_STRING){
                                        String topic = parser.getText();
                                        summary += 'topic: '+topic+', ';
                                    }
                                }
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'score')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_NUMBER_FLOAT){
                                        String score2 = parser.getText();
                                        summary += 'score: '+score2+', ';
                                    }
                                }
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'original_text')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_STRING){
                                        String original_text = parser.getText();
                                        summary += 'original_text: '+original_text+', ';
                                    }
                                }
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'original_length')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_NUMBER_INT){
                                        String original_length = parser.getText();
                                        summary += 'original_length: '+original_length+', ';
                                    }
                                }
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'normalized_text')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_STRING){
                                        String normalized_text = parser.getText();
                                        summary += 'normalized_text: '+normalized_text+', ';
                                    }
                                }
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'normalized_length')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_NUMBER_INT){
                                        String normalized_length = parser.getText();
                                        summary += 'normalized_length: '+normalized_length+', ';
                                    }
                                }
                            }
                            System.debug('summary: '+summary);
                            summary += '\r\n\r\n';
                        }
                    }
                }
            }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getCurrentName() == 'negative')) {
                summary += '\r\n--negative--\r\n';
                parser.nextToken();
                if (parser.getCurrentToken() == JSONToken.START_ARRAY){
                    while (parser.nextToken() != JSONToken.END_ARRAY) {
                        if (parser.getCurrentToken() == JSONToken.START_OBJECT){
                            
                            while (parser.nextToken() != JSONToken.END_OBJECT) {
                                
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'sentiment')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_STRING){
                                        String sentiment3 = parser.getText();
                                        summary += 'sentiment: '+sentiment3+', ';
                                    }
                                }
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'topic')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_STRING){
                                        String topic = parser.getText();
                                        summary += 'topic: '+topic+', ';
                                    }
                                }
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'score')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_NUMBER_FLOAT){
                                        String score3 = parser.getText();
                                        summary += 'score: '+score3+', ';
                                    }
                                }
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'original_text')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_STRING){
                                        String original_text = parser.getText();
                                        summary += 'original_text: '+original_text+', ';
                                    }
                                }
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'original_length')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_NUMBER_INT){
                                        String original_length = parser.getText();
                                        summary += 'original_length: '+original_length+', ';
                                    }
                                }
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'normalized_text')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_STRING){
                                        String normalized_text = parser.getText();
                                        summary += 'normalized_text: '+normalized_text+', ';
                                    }
                                }
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                                    (parser.getCurrentName() == 'normalized_length')) {
                                    parser.nextToken();
                                    if (parser.getCurrentToken() == JSONToken.VALUE_NUMBER_INT){
                                        String normalized_length = parser.getText();
                                        summary += 'normalized_length: '+normalized_length+', ';
                                    }
                                }
                            }
                            System.debug('summary: '+summary);
                            summary += '\r\n\r\n';
                        }
                    }
                }
            }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getCurrentName() == 'aggregate')) {
                
                parser.nextToken();
                if (parser.getCurrentToken() == JSONToken.START_OBJECT){
                    
                    summary += '\r\n--aggregate--\r\n';
                    while (parser.nextToken() != JSONToken.END_OBJECT) {
                        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                            (parser.getCurrentName() == 'sentiment')) {
                                parser.nextToken();
                                if (parser.getCurrentToken() == JSONToken.VALUE_STRING){
                                    sentiment = parser.getText();
                                    summary += 'sentiment: '+sentiment+',';
                                }
                        }
                        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                            (parser.getCurrentName() == 'score')) {
                                parser.nextToken();
                                if (parser.getCurrentToken() == JSONToken.VALUE_NUMBER_FLOAT){
                                    score = parser.getText();
                                    summary += score+',';
                                }
                        }
                    }
                    System.debug('summary: '+summary);
                    summary += '\r\n\r\n';
                }
            }
        }
        
        String aggregateValue = sentiment+': '+score;
        String[] sentimentResponse = new List<String>{aggregateValue, summary};
        return sentimentResponse;
    }
}