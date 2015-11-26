import java.io.File;

import com.ceph.rados.IoCTX;
import com.ceph.rados.Rados;
import com.ceph.rados.exceptions.RadosException;

public class CephClient {
	public static void main(String args[]) {

		Rados cluster = new Rados("admin");
		System.out.println("Created cluster handle.");
		IoCTX io = null;

		try {
			File f = new File("/etc/ceph/ceph.conf");
			cluster.confReadFile(f);
			System.out.println("Read the configuration file.");

			cluster.connect();
			System.out.println("Connected to the cluster.");

			io = cluster.ioCtxCreate("data");
		} catch (RadosException e) {
			e.printStackTrace();
			return;
		}

		System.out.println("Writing objects");

		String oidone = "id1";
		String oidtwo = "id2";

		try {
			String contentone = "Hello World!";
			io.write(oidone, contentone);

			String contenttwo = "The cake is a lie";
			io.write(oidtwo, contenttwo);
		} catch (RadosException e) {
			e.printStackTrace();
			return;
		}

		System.out.println("Getting objects");
		try {
			String[] objects = io.listObjects();
			for (String object : objects)
				System.out.println(object);

			io.remove(oidone);
			io.remove(oidtwo);

			cluster.ioCtxDestroy(io);

		} catch (RadosException e) {
			e.printStackTrace();
			return;
		}
	}
}