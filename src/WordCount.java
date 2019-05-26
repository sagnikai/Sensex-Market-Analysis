import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;

public class WordCount {
  public static void main(String []args
		  )throws Exception{
	  Configuration conf=new Configuration();
	  Job job=Job.getInstance(conf,"wordcount");
	  job.setJarByClass(WordCount.class);
	  job.setMapperClass(MyMapper.class);
	  job.setReducerClass(MyReducer.class);
	  job.setOutputKeyClass(Text.class);
	  job.setOutputValueClass(IntWritable.class);
	  FileInputFormat.addInputPath(job,new Path(args[0]));
	  FileOutputFormat.setOutputPath(job, new Path(args[1]));
	  boolean bol=job.waitForCompletion(true);
	  System.exit(bol?0:1);
  }
  
  public static class MyMapper extends Mapper<LongWritable, Text, Text, IntWritable>{
	  private final static IntWritable one=new IntWritable(1);
	  private Text word = new Text();
	  public void map(LongWritable key, Text value, Context context
			  )throws IOException, InterruptedException{
		  StringTokenizer itr=new StringTokenizer(value.toString());
		  while(itr.hasMoreTokens()){
			  word.set(itr.nextToken());
			  context.write(word,one);
		  }
	  }
  }
  public static class MyReducer extends Reducer<Text, IntWritable, Text, IntWritable>{
	  private IntWritable result=new IntWritable();
	  public void reduce(Text key, Iterable<IntWritable> values,Context context
			  )throws IOException,InterruptedException{
		  int sum=0;
		  for(IntWritable val : values)
		  {
			  sum+=val.get();
		  }
		  result.set(sum);
		  context.write(key,result);
	  }
  }
}
