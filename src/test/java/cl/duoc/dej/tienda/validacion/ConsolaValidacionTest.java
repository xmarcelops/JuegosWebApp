package cl.duoc.dej.tienda.validacion;

import cl.duoc.dej.tienda.entity.Consola;
import java.util.Set;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import org.junit.Test;

public class ConsolaValidacionTest {
    
    @Test
    public void validar() {
        Consola consola = new Consola("a", "");
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        Validator validator = factory.getValidator();
        Set<ConstraintViolation<Consola>> violaciones = validator.validate(consola);
        for(ConstraintViolation<Consola> v:violaciones) {
            System.out.println(v.getPropertyPath().toString() +" : "+ v.getMessage());
        }
    }
    
}
