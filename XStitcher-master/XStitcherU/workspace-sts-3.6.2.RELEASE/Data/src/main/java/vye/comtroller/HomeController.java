package vye.comtroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author Petri Kainulainen
 */
@Controller
public class HomeController {

    public static final String HOME_VIEW = "home";

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String showPage() {
        return HOME_VIEW;
    }
}