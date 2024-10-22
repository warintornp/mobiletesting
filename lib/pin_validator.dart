class PinValidator {

  PinValidator();

  bool validatePin(String pin) {
    return _hasSequentialDigits(pin) || _hasRepeatingDigits(pin);
  }

  bool _hasSequentialDigits(String pin) {    
    // Check for sequential digits     
    for (int i = 0; i < 5; i++) {       
      if (pin[i].codeUnitAt(0) + 1 == pin[i + 1].codeUnitAt(0)) {         
        return true; // Found sequential digits       
      }     
    }
    return false;   
  }

  bool _hasRepeatingDigits(String pin) {     
    // Check for repeating digits     
    Set<String> digitSet = <String>{};     
    for (int i = 0; i < pin.length; i++) {       
      if (digitSet.contains(pin[i])) {         
        return true; // Found repeating digit       
      }      
      digitSet.add(pin[i]);     
    }     
    return false;   
  }
}