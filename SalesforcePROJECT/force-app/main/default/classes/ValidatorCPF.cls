public with sharing class ValidatorCPF {
    public class CPFValidationException extends Exception {}

    public static Boolean isValidCPF(String cpf) {
        if (cpf == null || cpf.trim().length() == 0) {
            return false;
        }

        // Remove caracteres não numéricos do CPF
        String cleanCpf = cpf.replaceAll('[^0-9]', '');
        
        // Verifica se o CPF tem 11 dígitos
        if (cleanCpf.length() != 11) {
            return false;
        }
        
        // Verifica se todos os dígitos são iguais
        if (cleanCpf.replaceAll(cleanCpf.substring(0,1), '').length() == 0) {
            return false;
        }

        // Cálculo dos dígitos verificadores
        Integer digit1 = calculateVerifierDigit(cleanCpf, 9);
        Integer digit2 = calculateVerifierDigit(cleanCpf, 10);

        return (digit1 == Integer.valueOf(cleanCpf.substring(9, 10)) &&
                digit2 == Integer.valueOf(cleanCpf.substring(10, 11)));
    }

    public static Integer calculateVerifierDigit(String cpf, Integer position) {
        Integer sum = 0;
        Integer weight = position + 1;
        for (Integer i = 0; i < position; i++) {
            sum += Integer.valueOf(cpf.substring(i, i+1)) * weight;
            weight--;
        }
        Integer remainder = Math.mod(sum, 11);
        return (remainder < 2) ? 0 : (11 - remainder);
    }

    public static void validateAccounts(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            if (String.isBlank(acc.CPF__c)) {
                acc.addError('CPF não pode ser vazio.');
            } else if (!isValidCPF(acc.CPF__c)) {
                acc.addError('CPF inválido: ' + acc.CPF__c);
            }
        }
    }
}