using ScottPlot;
using System.Drawing;
using System.Threading;
using System.Windows.Forms;

namespace FarNet.ScottPlot;

/// <summary>
/// This type derives from <see cref="Plot"/> and provides additional form members including the method <see cref="Show"/>.
/// </summary>
public class FormPlot : Plot
{
    /// <summary>
    /// The form title.
    /// </summary>
    public string FormTitle { get; set; }

    /// <summary>
    /// Thell to wait for the form exit.
    /// </summary>
    public bool FormWait { get; set; }

    /// <summary>
    /// Shows this plot in a form.
    /// </summary>
    public void Show()
    {
        void worker()
        {
            using var form = CreateForm();
            form.ShowDialog();
        }

        var thread = new Thread(worker)
        {
            Name = "Plot thread.",
            IsBackground = true
        };
        thread.SetApartmentState(ApartmentState.STA);
        thread.Start();

        if (FormWait)
            thread.Join();
    }

    Form CreateForm()
    {
        var form = new Form()
        {
            Text = FormTitle ?? "Plot"
        };

        var formsPlot = new FormsPlot
        {
            Dock = DockStyle.Fill
        };

        form.Controls.Add(formsPlot);
        form.Size = new Size((int)Width, (int)Height);
        formsPlot.Reset(this);

        form.Load += (s, e) =>
        {
            form.Activate();
        };

        formsPlot.KeyDown += (s, e) =>
        {
            if (e.KeyCode == Keys.Escape)
                form.Close();
        };

        return form;
    }
}
