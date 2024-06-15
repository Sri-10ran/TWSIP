import java.util.*; // I included Random, Scanner, InputMismatchException classes in this program

class Task1 {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        Random r = new Random();
        int computer = r.nextInt(101); 
        System.out.println("\t\t\t\tThe Number Guessing Game Begins...!");
        System.out.println("\t\t\t\t------------------------------------");
        System.out.println("\t\t\t\tYou have 5 chances to find the number from 0 to 100");

        int chance = 5;

        while (chance > 0) {
            System.out.println("Enter your number which you guessed:");

            try {
                int user = s.nextInt();
		if (user < 0 || user > 100) {     //I ensure the user to enter the number which is not to be less than 0 
  						  //and greater than 100
                    System.out.println("Your number should be from 0 to 100. Try again.");
                } else {
                    if (user < computer) {
                        System.out.println("Your guess is lower.");
                    } else if (user > computer) {
                        System.out.println("Your guess is higher.");
                    } else {
                        System.out.println("Your guess is right! Congratulations!");
                        break;
                    }
                    chance--;
                    if (chance > 0) {
                        System.out.println("You have " + chance + " chance(s) left.");
                    } else {
                        System.out.println("Sorry, you're out of chances. The correct number was " + computer);
                    }
                }
            } catch (InputMismatchException e) {
                
                System.out.println("You entered input is other than number. Enter a number from 0 to 100.");

                s.next(); 
            }
        }

        s.close();
    }
}
