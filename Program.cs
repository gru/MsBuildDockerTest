using System;
using System.Linq;
using Microsoft.Build.Evaluation;
using Microsoft.Build.Locator;

namespace MsBuildDockerTest
{
    public class Program
    {
        static Program()
        {
            MSBuildLocator.RegisterDefaults();
        }
    
        public static void Main()
        {
            var sample = new MsBuildSample();
            var value = sample.EvaluateHelloWorldProperty();

            Console.WriteLine(value);
        }
    }

    public class MsBuildSample
    {
        public string EvaluateHelloWorldProperty()
        {
            var project = new Project(@"MsBuildDockerTest.csproj");
            var property = project.Properties
                .Single(p => p.Name == "HelloWorld");

            return property.EvaluatedValue;
        }
    }
}
