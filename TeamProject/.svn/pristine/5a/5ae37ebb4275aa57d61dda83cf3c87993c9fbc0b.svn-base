package com.gsitm.scheduler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;

@WebServlet("/SchedulerRunAction")
public class SchedulerRunAction extends HttpServlet {
	private static final long serialVersionUID = -4013616887475315494L;
	private SchedulerFactory schedulerFactory;
	private Scheduler scheduler;

	public SchedulerRunAction () {
		try {
			schedulerFactory  = new StdSchedulerFactory();
			scheduler = schedulerFactory.getScheduler();
			System.out.println("SchedulerRun");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public void init() {
		try {
			JobDetail job1 = new JobDetail("job1", Scheduler.DEFAULT_GROUP, JobAction.class);
			
			//test
			//CronTrigger trigger1  = new CronTrigger("job1", Scheduler.DEFAULT_GROUP, "10 * * * * ?");
			CronTrigger trigger1  = new CronTrigger("job1", Scheduler.DEFAULT_GROUP, "0 0/30 * * * ?");
			scheduler.scheduleJob(job1, trigger1);
			scheduler.start();
			System.out.println("Scheduler init");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}