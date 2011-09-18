package application;
import library.MethodFromSignature;

public class Main {

	public static void main(String[] args) throws ClassNotFoundException, SecurityException, NoSuchMethodException {
		
		SimpleInterface simpleInterface = new SimpleClass();

		//simpleInterface.method(3, new SimpleClass());
		simpleInterface.method(3);
		//simpleInterface.someOtherMethod();
		
		//MethodFromSignature mfs = new MethodFromSignature("void B.method(int)");
	}

}
