package com.aboutrip.app.place;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller("place.placeController")
@RequestMapping("/place/*")
public class PlaceController {
	
	@RequestMapping("list")
	public ModelAndView placelist() throws Exception{
		return new ModelAndView(".place.list");
	}
	
	@RequestMapping("mdPick")
	public ModelAndView mdPick() throws Exception{
		return new ModelAndView(".place.mdPick");
	}
	
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm() throws Exception{
		return ".place.create";
	}
	
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String createSubmit() throws Exception{
		return "redirect:/place/list";
	}
	
	@RequestMapping(value = "createMd", method = RequestMethod.GET)
	public String createMdForm() throws Exception{
		return ".place.createMd";
	}
	
	@RequestMapping(value = "createMd", method = RequestMethod.POST)
	public String createMdSubmit() throws Exception{
		return "redirect:/place/mdPick";
	}
	
	
	
	
}