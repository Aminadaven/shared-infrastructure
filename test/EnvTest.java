import java.util.Map;
import java.util.Properties;

public class EnvTest {

  public static void main(String args[]) {
    System.out.println("***************************Environment Vars**************************");
    System.getenv().entrySet().forEach(System.out::println);
  }
}
