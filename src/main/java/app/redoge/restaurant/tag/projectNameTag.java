package app.redoge.restaurant.tag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class projectNameTag extends TagSupport {

    public int doStartTag() throws JspException {
        JspWriter out=pageContext.getOut();
        try{
            out.print("Restaurant");
        }catch(Exception e){System.out.println(e);}
        return SKIP_BODY;
    }
}