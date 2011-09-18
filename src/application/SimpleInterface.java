package application;

public interface SimpleInterface {

	@ImportantMethod()
	void method(int a, SimpleClass c);
	
	void method(int a);
	
	void someOtherMethod();
}
