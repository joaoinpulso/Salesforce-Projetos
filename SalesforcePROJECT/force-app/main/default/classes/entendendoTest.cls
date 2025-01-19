/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class entendendoTest {

    @isTest
    static void testCheckDatesWithin30Days() {
            // Testar se date2 está dentro de 30 dias de date1
            Date date1 = Date.today();
            Date date2 = date1.addDays(15);
            Date result = VerifyDate.CheckDates(date1, date2);
            System.assertEquals(date2, result, 'Date2 deveria ser retornada pois está dentro do intervalo de 30 dias');
        }
    @isTest
    static void testCheckDatesOutside30days(){
            // Testar se date2 está fora do intervalo de 30 dias
            Date date1 = Date.today();
            Date date2 = date1.addDays(45);
            Date expectedDate = Date.newInstance(date1.year(), date1.month(), Date.daysInMonth(date1.year(), date1.month()));
            Date result = VerifyDate.CheckDates(date1, date2);
            System.assertEquals(expectedDate, result, 'A data retornada deveria ser o último dia do mês de date1');

        }

    @isTest
    static void testCheckDatesInThePast(){
            // Testar se date2 está fora do intervalo de 30 dias
            Date date1 = Date.today();
            Date date2 = date1.addDays(-5);
            Date expectedDate = Date.newInstance(date1.year(), date1.month(), Date.daysInMonth(date1.year(), date1.month()));
            Date result = VerifyDate.CheckDates(date1, date2);
            System.assertEquals(expectedDate, result, 'A data retornada deveria ser o último dia do mês de date1');
            
        }
}