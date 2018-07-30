import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) throws IOException {
		String[] images = {"plane", "culturalcentre", "randomimage", "wintertrees", "autumntrees", "sunset", "poolballs", "umbrella", "nightshot", "gradient", "lipsum", "dragon", "face", "rays", "ducks"};
		String[] infixes = {"libjpeg-turbo", "mozjpeg", "jpegoptim", "jpeg-recompress"};
		for (String infx : infixes){
			for (String o : images){
				String infix = infx;
				String image = o;
				String path = "H:\\EE\\Images\\TO USE\\";
				String disk = "H:";

				// code adapted https://stackoverflow.com/questions/15464111/run-cmd-commands-through-java
				ProcessBuilder builder = new ProcessBuilder(
						"cmd.exe", "/c", disk + " && cd \"" + path + "\" && SCRIPT1 " + infix + " " + image);
				builder.redirectErrorStream(true);
				Process p = builder.start();
				BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
				String line;
				while (true) {
					line = r.readLine();
					if (line == null) { break; }
					System.out.println(line);
				}

				String inpath = new String(path + image + "_" + infix + ".log");
				String outpath = new String(path + image + "_" + infix + "_CLEAN" + ".csv");
				File inputFilepath = new File(inpath);
				File outputFilepath = new File(outpath);

				Scanner input = new Scanner(inputFilepath);
				PrintWriter writer = new PrintWriter(outputFilepath);

				String writerString = "";
				while (input.hasNextLine()) {
					String temp = input.nextLine();
					if (temp.contains("Execution time: ")) {
						String[] tempSplit = temp.split(" ");
						writerString += "," + tempSplit[2];	
					}
					else if (temp.contains("datatoken#")) {
						String[] tempSplit = temp.split("#");
						writerString = tempSplit[1] + writerString;
						writer.println(writerString);
						writerString = "";
					}
				}

				System.out.println("done");

				String nppPath = "H:\\Program Files\\Notepad++\\notepad++.exe";

				ProcessBuilder nppout = new ProcessBuilder("\"" + nppPath + "\" \"" + outpath + "\"");
				nppout.redirectErrorStream(true);
				nppout.start();

				input.close();
				writer.close();

				System.out.println(o + " done");
			}
		}
	}
}
