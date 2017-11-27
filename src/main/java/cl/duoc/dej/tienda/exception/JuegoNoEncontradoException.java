package cl.duoc.dej.tienda.exception;

public class JuegoNoEncontradoException extends Exception {

    public JuegoNoEncontradoException() {
    }

    /**
     * Constructs an instance of <code>ProductoNoEncontradoException</code> with
     * the specified detail message.
     *
     * @param msg the detail message.
     */
    public JuegoNoEncontradoException(String msg) {
        super(msg);
    }
}
