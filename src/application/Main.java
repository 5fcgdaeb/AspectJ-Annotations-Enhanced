package application;

public class Main {

	public static void main(String[] args) throws ClassNotFoundException, SecurityException, NoSuchMethodException {
		
		SimpleInterface simpleInterface = new SimpleClass();

		simpleInterface.method(3, new SimpleClass());
		
		simpleInterface.method(3);
		
		simpleInterface.someOtherMethod();
	}

}
