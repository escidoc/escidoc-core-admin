package de.escidoc.core.admin.common.util;
import java.io.IOException;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.UnsupportedCallbackException;
import org.apache.ws.security.WSPasswordCallback;

public class PWCallback implements CallbackHandler {
	
	private String user = null;
	private String password = null;
	
	public PWCallback() {
	}
	
	public PWCallback(String user, String password) {
		this.user = user;
		this.password = password;
	}
	
    public void handle(final Callback[] callbacks) throws IOException, UnsupportedCallbackException {
        for (int i = 0; i < callbacks.length; i++) {
            if (callbacks[i] instanceof WSPasswordCallback) {
                WSPasswordCallback pc = (WSPasswordCallback)callbacks[i];
                // set the password given a username
                if (user.equals(pc.getIdentifer())) {
                    pc.setPassword(password);
                }
            } else {
                throw new UnsupportedCallbackException(callbacks[i], "Unrecognized Callback");
            }
        }
    }
}
    
